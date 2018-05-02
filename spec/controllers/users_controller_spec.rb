require 'spec_helper'

describe UsersController do

  let(:body) { JSON.parse(response.body, symbolize_names: true) }

  describe "POST /users" do
    before do
      post :create, params: params, format: :json
    end

    context "when all necessary params are present" do
      let(:params) do
        {
          user: {
            name: "Gabriel Queiroz",
            email: "unique.email@test.com",
            password: "test",
            password_confirmation: "test"
          }
        }
      end

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

    context "when email has already been taken" do
      let(:user) { create(:user) }
      let(:params) do
        {
          user: {
            name: "Gabriel Queiroz",
            email: "gabriel.queiroz@test.com",
            password: "test",
            password_confirmation: "test"
          }
        }
      end

      it { expect(body[:message]).to eq 'Validation failed: Email has already been taken' }
      it { expect(response.status).to eq 400 }
    end

    context "when password confirmation doesn't match password" do
      let(:params) do
        {
          user: {
            name: "Gabriel Queiroz",
            email: "password@test.com",
            password: "password",
            password_confirmation: "different"
          }
        }
      end

      it { expect(body[:message]).to eq "Validation failed: Password confirmation doesn't match Password" }
      it { expect(response.status).to eq 400 }
    end

    context "when email is invalid" do
      let(:params) do
        {
          user: {
            name: "Gabriel Queiroz",
            email: "email-invalid",
            password: "test",
            password_confirmation: "test"
          }
        }
      end

      it { expect(body[:message]).to eq "Validation failed: Email is invalid" }
      it { expect(response.status).to eq 400 }
    end

  end

end
