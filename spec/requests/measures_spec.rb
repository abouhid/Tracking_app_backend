# spec/requests/measures_spec.rb
require 'rails_helper'

RSpec.describe 'measures API' do
  # Initialize the test data
  let!(:measurement) { create(:measurement) }
  let!(:measures) { create_list(:measure, 20, measurement_id: measurement.id) }
  let(:measurement_id) { measurement.id }
  let(:id) { measures.first.id }

  # Test suite for GET /measurements/:measurement_id/measures
  describe 'GET /measurements/:measurement_id/measures' do
    before { get "/measurements/#{measurement_id}/measures" }

    context 'when measurement exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all measurement measures' do
        expect(json.size).to eq(20)
      end
    end

    context 'when measurement does not exist' do
      let(:measurement_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/\"message\":\"Couldn't find Measurement with 'id'=0\"/)
      end
    end
  end

  # Test suite for GET /measurements/:measurement_id/measures/:id
  describe 'GET /measurements/:measurement_id/measures/:id' do
    before { get "/measurements/#{measurement_id}/measures/#{id}" }

    context 'when measurement measure exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the measure' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when measurement measure does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Measure with [WHERE \\\"measures\\\".\\\"measurement_id\\\" = ? AND \\\"measures\\\".\\\"id\\\" = ?]\"}")
      end
    end
  end

  # Test suite for PUT /measurements/:measurement_id/measures
  describe 'POST /measurements/:measurement_id/measures' do
    let(:valid_attributes) { { type_of_measure: 'Visit Narnia' } }

    context 'when request attributes are valid' do
      before { post "/measurements/#{measurement_id}/measures", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/measurements/#{measurement_id}/measures", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Type of measure can't be blank/)
      end
    end
  end

  # Test suite for PUT /measurements/:measurement_id/measures/:id
  describe 'PUT /measurements/:measurement_id/measures/:id' do
    let(:valid_attributes) { { type_of_measure: 'Mozart' } }

    before { put "/measurements/#{measurement_id}/measures/#{id}", params: valid_attributes }

    context 'when measure exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the measure' do
        updated_measure = Measure.find(id)
        expect(updated_measure.type_of_measure).to match(/Mozart/)
      end
    end

    context 'when the measure does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Measure with [WHERE \\\"measures\\\".\\\"measurement_id\\\" = ? AND \\\"measures\\\".\\\"id\\\" = ?]\"}")
      end
    end
  end

  # Test suite for DELETE /measurements/:id
  describe 'DELETE /measurements/:id' do
    before { delete "/measurements/#{measurement_id}/measures/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end