# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let(:login_user) { create(:user) }
  let(:sign_in_user) { create(:user) }

  before { sign_in sign_in_user, scope: :user }

  describe 'GET index' do
    let!(:tasks) { create_list(:task, 3, user: sign_in_user) }

    it do
      get tasks_url
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET new' do
    subject { get new_task_url }

    it do
      subject
      expect(response).to have_http_status :ok
    end
  end

  describe 'POST create' do
    subject { post tasks_url, params: { task: task_params } }

    context 'when valid' do
      let(:task_params) do
        { title: 'title', description: 'description', done: false }
      end

      it do
        subject
        task = Task.last
        expect(response).to redirect_to task_url(id: task.id)

        expect(task.user_id).to eq(sign_in_user.id)
        expect(task.title).to eq('title')
        expect(task.description).to eq('description')
        expect(task.done).to be(false)
      end
    end

    context 'when invalid' do
      let(:task_params) { { title: '' } }

      it do
        subject
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'GET edit' do
    subject { get edit_task_url(id: task.id) }

    let(:task) { create(:task, user: sign_in_user) }

    it do
      subject
      expect(response).to have_http_status :ok
    end
  end

  describe 'PATCH update' do
    subject { patch task_url(id: task.id), params: { task: task_params } }

    let(:task) { create(:task, user: sign_in_user) }

    context 'when valid' do
      let(:task_params) do
        { title: 'title', description: 'description', done: false }
      end

      it do
        subject
        expect(response).to redirect_to task_url(id: task.id)

        task.reload
        expect(task.user_id).to eq(sign_in_user.id)
        expect(task.title).to eq('title')
        expect(task.description).to eq('description')
        expect(task.done).to be(false)
      end
    end

    context 'when invalid' do
      let(:task_params) { { title: '' } }

      it do
        subject
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'DELETE destroy' do
    subject { delete task_url(id: task.id) }

    let(:task) { create(:task, user: sign_in_user) }

    it do
      subject
      expect(Task.where(id: task.id)).not_to be_exists
    end
  end
end
