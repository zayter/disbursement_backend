# frozen_string_literal: true

shared_examples 'unauthorized' do
  context 'with unauthorized user' do
    let(:user) { build(:user) }

    it 'returns unauthorized data' do
      subject

      expect(response).to have_http_status :unauthorized
      expect(body_json['errors']).to eq('You are not authorized to access this page.')
    end
  end
end
