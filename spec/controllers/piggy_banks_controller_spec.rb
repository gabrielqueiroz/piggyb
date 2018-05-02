require 'spec_helper'

include ActionController::HttpAuthentication::Basic

describe PiggyBanksController do

  context "GET /piggy_banks" do
    let(:session) { Hash.new }
    let(:authorization) { '' }
    let(:piggy_bank) { create(:piggy_bank) }
    let(:user) { piggy_bank.user }

    before do
      request.env['HTTP_AUTHORIZATION'] = authorization
      get :index, format: request_format, session: session
    end

    context "when return a list of Piggy Banks" do

      context "using HTML format" do
        let(:request_format) { :html }
        let(:session) do
          { user_id: piggy_bank.user_id }
        end

        it { expect(subject).to render_template(:index) }
        it { expect(assigns(:summary)).not_to be_nil }
        it { expect(assigns(:summary).sum_of_balance).to eq 200.0 }
        it { expect(assigns(:summary).sum_of_credit).to eq 300.0 }
        it { expect(assigns(:summary).sum_of_debit).to eq 100.0 }
        it { expect(assigns(:piggy_banks)).not_to be_nil }
        it { expect(assigns(:piggy_banks).first.name).to eq 'PS4 Games' }
        it { expect(assigns(:piggy_banks).first.currency).to eq 'CAD' }
        it { expect(assigns(:piggy_banks).first.description).to eq 'My PS4 Games' }
        it { expect(assigns(:piggy_banks).first.balance).to eq 200.0 }
        it { expect(assigns(:piggy_banks).first.total_credit).to eq 300.0 }
        it { expect(assigns(:piggy_banks).first.total_debit).to eq 100.0 }
      end

      context "using JSON format" do
        let(:request_format) { :json }
        let(:authorization) { encode_credentials(user.email, user.password) }

        let(:body) { JSON.parse(response.body, symbolize_names: true) }

        it { expect(response.status).to eq 200 }
        it { expect(body[:summary]).not_to be_nil }
        it { expect(body[:summary][:sum_of_balance]).to eq 200.0 }
        it { expect(body[:summary][:sum_of_credit]).to eq 300.0 }
        it { expect(body[:summary][:sum_of_debit]).to eq 100.0 }
        it { expect(body[:piggy_banks].first[:name]).to eq 'PS4 Games' }
        it { expect(body[:piggy_banks].first[:currency]).to eq 'CAD' }
        it { expect(body[:piggy_banks].first[:description]).to eq 'My PS4 Games' }
        it { expect(body[:piggy_banks].first[:balance]).to eq 200.0 }
        it { expect(body[:piggy_banks].first[:total_credit]).to eq 300.0 }
        it { expect(body[:piggy_banks].first[:total_debit]).to eq 100.0 }
      end

    end

    context "when return an empty list of Piggy Banks" do
      let(:user) { create(:user, :random_email) }

      context "using HTML format" do
        let(:request_format) { :html }
        let(:session) do
          { user_id: user.id }
        end

        it { expect(subject).to render_template(:index) }
        it { expect(assigns(:summary)).not_to be_nil }
        it { expect(assigns(:summary).sum_of_balance).to eq 0 }
        it { expect(assigns(:summary).sum_of_credit).to eq 0 }
        it { expect(assigns(:summary).sum_of_debit).to eq 0 }
        it { expect(assigns(:piggy_banks)).to be_empty }
      end

      context "using JSON format" do
        let(:request_format) { :json }
        let(:authorization) { encode_credentials(user.email, user.password) }
        let(:body) { JSON.parse(response.body, symbolize_names: true) }

        it { expect(response.status).to eq 200 }
        it { expect(body[:summary][:sum_of_balance]).to eq 0 }
        it { expect(body[:summary][:sum_of_credit]).to eq 0 }
        it { expect(body[:summary][:sum_of_debit]).to eq 0 }
        it { expect(body[:piggy_banks]).to be_empty }
      end
    end

    context "raise exception when user not found" do

      context "using JSON format" do
        let(:request_format) { :json }
        let(:authorization) { encode_credentials('user.not.found@test.com', 'test') }

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
      let(:request_format) { :json }
      let(:params) do
        {
          piggy_bank: {
            name: "Switch Games",
            description: "My Switch Games",
            currency: "CDN",
            balance: 100.0
          }
        }
      end
      let(:authorization) { encode_credentials(user.email, user.password) }
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

    context "update piggy bank description" do
      let(:request_format) { :json }
      let(:params) do
        {
          id: piggy_bank.id,
          piggy_bank: { description: "Updated description" }
        }
      end

      let(:authorization) { encode_credentials(user.email, user.password) }
      let(:body) { JSON.parse(response.body, symbolize_names: true) }

      it { expect(response.status).to eq 200 }
      it { expect(body).not_to be_nil }
      it { expect(body[:description]).to eq 'Updated description' }
    end

  end

end
