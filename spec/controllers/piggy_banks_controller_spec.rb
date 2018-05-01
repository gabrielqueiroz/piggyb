require 'spec_helper'

describe PiggyBanksController do

  context "GET /piggy_banks" do
    let(:session) { Hash.new }
    let(:authorization) { '' }
    let(:piggy_bank) { create(:piggy_bank) }
    let(:user) { piggy_bank.user }

    context "return a list of Piggy Banks" do
      before do
        request.env['HTTP_AUTHORIZATION'] = authorization
        get :index, format: request_format, session: session
      end

      context "using session" do
        let(:session) { { user_id: piggy_bank.user_id } }
        let(:request_format) { :html }

        it { expect(subject).to render_template(:index) }
        it { expect(assigns(:piggy_banks)).not_to be_nil }
        it { expect(assigns(:piggy_banks).first.name).to eq 'PS4 Games' }
        it { expect(assigns(:piggy_banks).first.currency).to eq 'CAD' }
        it { expect(assigns(:piggy_banks).first.description).to eq 'My PS4 Games' }
        it { expect(assigns(:piggy_banks).first.balance).to eq 200.0 }
        it { expect(assigns(:piggy_banks).first.total_credit).to eq 300.0 }
        it { expect(assigns(:piggy_banks).first.total_debit).to eq 100.0 }
      end

      context "using basic auth" do
        let(:authorization) { ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password) }
        let(:request_format) { :json }
        let(:body) { JSON.parse(response.body, symbolize_names: true) }

        it { expect(response.status).to eq 200 }
        it { expect(body.first[:name]).to eq 'PS4 Games' }
        it { expect(body.first[:currency]).to eq 'CAD' }
        it { expect(body.first[:description]).to eq 'My PS4 Games' }
        it { expect(body.first[:balance]).to eq 200.0 }
        it { expect(body.first[:total_credit]).to eq 300.0 }
        it { expect(body.first[:total_debit]).to eq 100.0 }
      end

    end

    context "return an empty list of Piggy Banks" do
      let(:user) { create(:user, :random_email) }

      before do
        request.env['HTTP_AUTHORIZATION'] = authorization
        get :index, format: request_format, session: session
      end

      context "using session" do
        let(:session) { { user_id: user.id } }
        let(:request_format) { :html }

        it { expect(subject).to render_template(:index) }
        it { expect(assigns(:piggy_banks)).to be_empty }
      end

      context "using basic auth" do
        let(:authorization) { ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password) }
        let(:request_format) { :json }
        let(:body) { JSON.parse(response.body, symbolize_names: true) }

        it { expect(response.status).to eq 200 }
        it { expect(body).to be_empty }
      end
    end

    context "raise exception when user not found" do
      before do
        request.env['HTTP_AUTHORIZATION'] = authorization
        get :index, format: request_format, session: session
      end

      context "using basic auth" do
        let(:authorization) { ActionController::HttpAuthentication::Basic.encode_credentials('user.not.found@test.com', 'test') }
        let(:request_format) { :json }
        let(:body) { JSON.parse(response.body, symbolize_names: true) }

        it { expect(response.status).to eq 404 }
        it { expect(body[:message]).to eq "Couldn't find User" }
      end
    end

  end

  context "POST /piggy_banks" do
    let(:user) { create(:user, :random_email) }
    before do
      request.env['HTTP_AUTHORIZATION'] = authorization
      post :create, params: params, format: request_format
    end

    context "when all necessary params are present" do
      let(:params) {
        {
          piggy_bank: {
            name: "Switch Games",
            description: "My Switch Games",
            currency: "CDN",
            balance: 100.0
          }
        }
      }
      let(:request_format) { :json }
      let(:authorization) { ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password) }
      let(:body) { JSON.parse(response.body, symbolize_names: true) }

      it { expect(response.status).to eq 201 }
      it { expect(body).not_to be_nil }
      it { expect(body[:name]).to eq 'Switch Games' }
      it { expect(body[:description]).to eq 'My Switch Games' }
      it { expect(body[:currency]).to eq 'CDN' }
      it { expect(body[:balance]).to eq 100.0 }
    end
  end

  context "PUT /piggy_banks" do
    let(:piggy_bank) { create(:piggy_bank) }
    let(:user) { piggy_bank.user }

    before do
      request.env['HTTP_AUTHORIZATION'] = authorization
      put :update, params: params, format: request_format
    end

    context "update using basic auth" do
      let(:params) {
        {
          id: piggy_bank.id,
          piggy_bank: { description: "Updated description" }
        }
      }
      let(:request_format) { :json }
      let(:authorization) { ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password) }
      let(:body) { JSON.parse(response.body, symbolize_names: true) }

      it { expect(response.status).to eq 200 }
      it { expect(body).not_to be_nil }
      it { expect(body[:description]).to eq 'Updated description' }
    end

  end

end
