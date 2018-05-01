require 'spec_helper'

describe UsersController do

  let(:body) { JSON.parse(response.body, symbolize_names: true) }

  describe "POST /users" do
    before do
      create(:user)
      post :create, params: params, format: :json
    end

    context "when all necessary params are present" do
      let(:params) {
        { user: {
          name: "Gabriel Queiroz",
          email: "unique.email@test.com",
          password: "test",
          password_confirmation: "test"
          }
        }
      }

      it { expect(body[:name]).to eq "Gabriel Queiroz" }
      it { expect(body[:email]).to eq "unique.email@test.com" }
      it { expect(body[:password_digest]).to be_nil }
      it { expect(response.status).to eq 201 }
    end

    context "when params are missing" do
      let(:params) { Hash.new }

      it { expect(body[:message]).to eq 'param is missing or the value is empty: user' }
      it { expect(response.status).to eq 400 }
    end

    context "when email is already present " do
      let(:params) {
        { user: {
            name: "Gabriel Queiroz",
            email: "gabriel.queiroz@test.com",
            password: "test",
            password_confirmation: "test"
          }
        }
      }

      it { expect(body[:message]).to eq 'Validation failed: Email has already been taken' }
      it { expect(response.status).to eq 400 }
    end

    context "when password is different from confirmation" do
      let(:params) {
        { user: {
            name: "Gabriel Queiroz",
            email: "password@test.com",
            password: "password",
            password_confirmation: "different"
          }
        }
      }

      it { expect(body[:message]).to eq "Validation failed: Password confirmation doesn't match Password" }
      it { expect(response.status).to eq 400 }
    end

  end

end
