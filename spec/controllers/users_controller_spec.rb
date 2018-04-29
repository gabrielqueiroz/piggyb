require 'spec_helper'

RSpec.describe UsersController do

  let(:body) { JSON.parse(response.body, symbolize_names: true) }

  describe "Create a new user" do
    before do
      post :create, params: params, format: :json
    end

    context "when all necessary params are present" do
      let(:params) {
        { user: {
          name: "Gabriel Queiroz",
          email: "gabriel.queiroz@test.com",
          password: "test",
          password_confirmation: "test"
          }
        }
      }

      it { expect(body[:name]).to eq "Gabriel Queiroz" }
      it { expect(body[:email]).to eq "gabriel.queiroz@test.com" }
      it { expect(body[:password_digest]).not_to be_nil }
      it { expect(response.status).to eq 201 }
    end

    context "when params are missing" do
      let(:params) { Hash.new }

      it { expect(body[:message]).to eq 'param is missing or the value is empty: user' }
      it { expect(response.status).to eq 400 }
    end

  end

end
