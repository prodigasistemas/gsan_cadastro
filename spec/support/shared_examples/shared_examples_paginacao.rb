require 'rails_helper'

shared_examples 'com dados da paginacao' do
  it "retorna dados da paginacao" do
    expect(json['page']['first_page']).to be true
    expect(json['page']['last_page']).to be true
    expect(json['page']['current_page']).to eq(1)
    expect(json['page']['total']).to eq(1)
    expect(json['page']['total_pages']).to eq(1)
  end
end

shared_examples 'sem dados da paginacao' do
  it "não retorna atributos da paginacao" do
    get :index, format: :json
    expect(json['page']).to be_nil
  end
end