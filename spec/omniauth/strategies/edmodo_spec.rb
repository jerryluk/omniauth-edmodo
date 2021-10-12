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

  context '#info' do
    before do
      allow(access_token).to receive(:get).with('users/me').and_return(response)
    end

    context 'when user signing in is a student' do
      let(:parsed_response) do
        { 'url' => 'https://api.edmodo.com/users/123', 'id' => 123, 'type' => 'student' }
      end

      it 'should return empty profile' do
        expect(subject.info).to eq({
          'nickname' => nil,
          'email' => nil,
          'first_name' => nil,
          'last_name' => nil,
          'image' => nil
        })
      end
    end

    context 'when user signing in is a teacher' do
      let(:parsed_response) do
        {
          'url' => 'https://api.edmodo.com/users/123',
          'id' => 123,
          'type' => 'teacher',
          'username' => 'name_here',
          'email' => 'name_here@example.org',
          'first_name' => 'FirstName',
          'last_name' => 'LastName',
          'avatars' => { 'large' => 'https://u.ph.edim.co/123/123.png' }
        }
      end

      it 'should return profile with nickname, email, first_name, last_name and image' do
        expect(subject.info).to eq({
          'nickname' => 'nickname',
          'email' => 'name_here@example.org',
          'first_name' => 'FirstName',
          'last_name' => 'LastName',
          'image' => 'https://u.ph.edim.co/123/123.png'
        })
      end

      context 'without an avatar' do
        let(:parsed_response) do
          {
           'url' => 'https://api.edmodo.com/users/123',
           'id' => 123,
           'type' => 'teacher',
           'username' => 'name_here',
           'email' => 'name_here@example.org',
           'first_name' => 'FirstName',
           'last_name' => 'LastName'
          }
        end

        it 'should include empty "image" property' do
          expect(subject.info).to include({ 'image' => nil })
        end
      end
    end
  end
end
