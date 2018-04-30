require 'spec_helper'

describe PiggyBanksController do

  context "List all PiggyBanks" do
    let(:session) { Hash.new }
    let(:authorization) { '' }

    context "return a list of Piggy Banks" do
      before do
        create(:user)
        create(:piggy_bank)
        request.env['HTTP_AUTHORIZATION'] = authorization
        get :index, format: request_format, session: session
      end

      context "using session" do
        let(:session) { { user_id: 1 } }
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
        let(:authorization) { ActionController::HttpAuthentication::Basic.encode_credentials('gabriel.queiroz@test.com','test') }
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
      before do
        create(:user)
        request.env['HTTP_AUTHORIZATION'] = authorization
        get :index, format: request_format, session: session
      end

      context "using session" do
        let(:session) { { user_id: 1 } }
        let(:request_format) { :html }

        it { expect(subject).to render_template(:index) }
        it { expect(assigns(:piggy_banks)).to be_empty }
      end

      context "using basic auth" do
        let(:authorization) { ActionController::HttpAuthentication::Basic.encode_credentials('gabriel.queiroz@test.com','test') }
        let(:request_format) { :json }
        let(:body) { JSON.parse(response.body, symbolize_names: true) }

        it { expect(response.status).to eq 200 }
        it { expect(body).to be_empty }
      end
    end

  end


end
