require 'spec_helper'

describe LoginsController do

  context "POST /logins" do
    let(:user) { create(:user, :random_email) }

    before do
      post :create, params: params, format: :html
    end

    context "when user exist in our databse" do
      let(:params) do
        {
          login: {
            email: user.email,
            password: user.password
          }
        }
      end

      it { expect(session[:user_id]).not_to be_nil }
      it { expect(response).to redirect_to piggy_banks_path }
    end

    context "when user does not in our databse" do
      let(:params) do
        {
          login: {
            email: 'user.not.found@test.com',
            password: 'test'
          }
        }
      end

      it { expect(session[:user_id]).to be_nil }
      it { expect(response).to redirect_to root_path }
    end
  end

  context "DELETE /logins" do
    before do
      delete :destroy, format: :html
    end

    context "clean user session" do
      it { expect(session[:user_id]).to be_nil }
      it { expect(response).to redirect_to root_path }
    end
  end

end
