require 'spec_helper'

include ActionController::HttpAuthentication::Basic

describe MovementsController do

  context "GET /piggy_banks/:id/movements" do
    let(:session) { Hash.new }
    let(:authorization) { '' }
    let(:movement) { create(:movement) }
    let(:piggy_bank) { movement.piggy_bank }
    let(:user) { piggy_bank.user }

    before do
      request.env['HTTP_AUTHORIZATION'] = authorization
      get :show, format: request_format, params: params, session: session
    end

    context "when there are movements for piggy bank" do
      let(:params) do
        { piggy_bank_id: piggy_bank.id }
      end

      context "using HTML format" do
        let(:request_format) { :html }
        let(:session) do
          { user_id: user.id }
        end

        it { expect(subject).to render_template(:show) }
        it { expect(assigns(:movements)).not_to be_nil }
        it { expect(assigns(:movements).first.name).to eq 'God of War' }
        it { expect(assigns(:movements).first.description).to eq 'Bought at EBGames Burnaby Canada' }
        it { expect(assigns(:movements).first.amount).to eq -60.0 }
      end

      context "using JSON format" do
        let(:request_format) { :json }
        let(:authorization) { encode_credentials(user.email, user.password) }

        let(:body) { JSON.parse(response.body, symbolize_names: true) }

        it { expect(response.status).to eq 200 }
        it { expect(body[:piggy_bank]).not_to be_nil }
        it { expect(body[:movements]).not_to be_nil }
        it { expect(body[:movements].first[:name]).to eq 'God of War' }
        it { expect(body[:movements].first[:description]).to eq 'Bought at EBGames Burnaby Canada' }
        it { expect(body[:movements].first[:amount]).to eq -60.0 }
      end
    end
  end

  context "POST /piggy_banks/:id/movements" do
    let(:piggy_bank) { create(:piggy_bank) }
    let(:user) { piggy_bank.user }

    before do
      request.env['HTTP_AUTHORIZATION'] = authorization
      post :create, params: params, format: request_format
    end

    context "when all necessary params are present" do
      let(:request_format) { :json }
      let(:params) do
        {
          piggy_bank_id: piggy_bank.id,
        	piggy_banks_movement: {
        		name: "Uncharted 4",
        		description: "Bought online at PSN",
        		amount: -60
        	}
        }
      end
      let(:authorization) { encode_credentials(user.email, user.password) }
      let(:body) { JSON.parse(response.body, symbolize_names: true) }

      it { expect(response.status).to eq 201 }
      it { expect(body).not_to be_nil }
      it { expect(body[:name]).to eq 'Uncharted 4' }
      it { expect(body[:description]).to eq 'Bought online at PSN' }
      it { expect(body[:amount]).to eq -60 }
    end
  end

  context "DELETE /piggy_banks/:id/movements?id=:movement_id" do
    let(:movement) { create(:movement) }
    let(:piggy_bank) { movement.piggy_bank }
    let(:user) { piggy_bank.user }

    before do
      request.env['HTTP_AUTHORIZATION'] = authorization
      delete :destroy, format: request_format, params: params
    end

    context "delete piggy bank" do
      let(:request_format) { :json }
      let(:random_user) { create(:user, :random_email) }
      let(:params) do
        {
          id: movement.id,
          piggy_bank_id: piggy_bank.id
        }
      end

      let(:authorization) { encode_credentials(user.email, user.password) }
      let(:body) { JSON.parse(response.body, symbolize_names: true) }

      it { expect(response.status).to eq 200 }
      it { expect(response.body).to eq 'Movement deleted' }
    end
  end

end
