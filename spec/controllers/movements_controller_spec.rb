require 'spec_helper'

describe MovementsController do

  context "GET /piggy_banks/:id/movements" do
    let(:session) { Hash.new }
    let(:authorization) { '' }

    context "when there is movements for piggy bank" do
      let(:params) { { piggy_bank_id: 1 } }

      before do
        create(:user)
        create(:piggy_bank)
        create(:movement)

        request.env['HTTP_AUTHORIZATION'] = authorization
        get :show, format: request_format, params: params, session: session
      end

      context "using session" do
        let(:session) { { user_id: 1 } }
        let(:request_format) { :html }

        it { expect(subject).to render_template(:show) }
        it { expect(assigns(:movements)).not_to be_nil }
        it { expect(assigns(:movements).first.name).to eq 'God of War' }
        it { expect(assigns(:movements).first.description).to eq 'Bought at EBGames Burnaby Canada' }
        it { expect(assigns(:movements).first.amount).to eq -60.0 }
      end

      context "using basic auth" do
        let(:authorization) { ActionController::HttpAuthentication::Basic.encode_credentials('gabriel.queiroz@test.com','test') }
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
