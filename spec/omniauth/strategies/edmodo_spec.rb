require 'spec_helper'

describe OmniAuth::Strategies::Edmodo do
  let(:access_token) { double('AccessToken', :options => {}) }
  let(:parsed_response) { double('ParsedResponse') }
  let(:response) { double('Response', :parsed => parsed_response) }

  let(:dev_site)          { 'https://localhost:3000' }
  let(:dev_authorize_url) { 'https://localhost:3000/oauth/authorize' }
  let(:dev_token_url)     { 'https://localhost:3000/oauth/token' }
  let(:dev) do
    OmniAuth::Strategies::Edmodo.new('EDMODO_KEY', 'EDMODO_SECRET', {
      client_options: {
        site: dev_site,
        authorize_url: dev_authorize_url,
        token_url: dev_token_url
      }
    })
  end

  subject do
    OmniAuth::Strategies::Edmodo.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq("https://api.edmodo.com")
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://api.edmodo.com/oauth/authorize')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('https://api.edmodo.com/oauth/token')
    end

    describe "should be overrideable" do
      it "for site" do
        expect(dev.options.client_options.site).to eq(dev_site)
      end

      it "for authorize url" do
        expect(dev.options.client_options.authorize_url).to eq(dev_authorize_url)
      end

      it "for token url" do
        expect(dev.options.client_options.token_url).to eq(dev_token_url)
      end
    end
  end

  context "#raw_info" do
    it "should use relative paths" do
      expect(access_token).to receive(:get).with('users/me').and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end
  end
end
