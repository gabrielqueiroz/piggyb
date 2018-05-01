require 'spec_helper'

describe MovementsController do

  context "GET /piggy_banks/:id/movements" do
    let(:session) { Hash.new }
    let(:authorization) { '' }
    let(:movement) { create(:movement) }
    let(:piggy_bank) { movement.piggy_bank }
    let(:user) { piggy_bank.user }

    context "when there is movements for piggy bank" do
      let(:params) { { piggy_bank_id: piggy_bank.id } }

      before do
        request.env['HTTP_AUTHORIZATION'] = authorization
        get :show, format: request_format, params: params, session: session
      end

      context "using session" do
        let(:session) { { user_id: user.id } }
        let(:request_format) { :html }

        it { expect(subject).to render_template(:show) }
        it { expect(assigns(:movements)).not_to be_nil }
        it { expect(assigns(:movements).first.name).to eq 'God of War' }
        it { expect(assigns(:movements).first.description).to eq 'Bought at EBGames Burnaby Canada' }
        it { expect(assigns(:movements).first.amount).to eq -60.0 }
      end

      context "using basic auth" do
        let(:authorization) { ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password) }
        let(:request_format) { :json }
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

end
