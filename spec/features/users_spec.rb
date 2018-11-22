# frozen_string_literal: true

require 'rails_helper'
# require 'capybara/rails'

RSpec.describe 'Users features' do
  before(:all) do
    @user = create(:user)
    @user_example = build(:user)
    create_list(:user, 10)
    @success_message = 'Operação efetuada com sucesso.'
  end

  it 'List of all users' do
    visit '/'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Acessar'
    click_link 'Lista de Usuários'
    expect(page).to have_content('Lista de Usuários')
    expect(page).to have_http_status 200

    # Implant Datatable result

    # Capybara.default_max_wait_time = 5
    # wait_for_ajax
    # require "timeout"
    # sleep(5)
    # expect(page).to have_content(@user.name)
    # expect(page).to have_content(@user.email)
    # expect(page).not_to have_link('Editar', href: user_path(@user))
    # expect(page).to have_content("rodrigo.toledo.dev@gmail.com")
  end

  it 'Create User' do
    visit '/'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Acessar'
    click_link 'Criar Usuário', match: :first

    fill_in 'user_name', with: @user_example.name
    fill_in 'user_email', with: @user_example.email
    fill_in 'user_password', with: @user_example.password
    fill_in 'user_password_confirmation', with: @user_example.password
    click_button 'Salvar'
    expect(page).to have_content(@success_message)
    expect(page).to have_http_status 200
  end

  it 'Create operador User' do
    visit '/'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Acessar'
    click_link 'Criar Usuário', match: :first

    fill_in 'user_name', with: @user_example.name
    fill_in 'user_email', with: @user_example.email
    fill_in 'user_password', with: @user_example.password
    fill_in 'user_password_confirmation', with: @user_example.password
    click_button 'Salvar'
    expect(page).to have_content(@success_message)
    expect(page).to have_http_status 200
  end

  it 'Fail on User with blank fields' do
    visit '/'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Acessar'
    click_link 'Criar Usuário', match: :first

    click_button 'Salvar'
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
  end

  it 'Fail on User with blank fields' do
    visit '/'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Acessar'
    click_link 'Criar Usuário', match: :first

    click_button 'Salvar'
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
  end

  it 'Fail on User with incorrect passwords' do
    visit '/'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Acessar'
    click_link 'Criar Usuário', match: :first

    fill_in 'user_name', with: @user_example.name
    fill_in 'user_email', with: @user_example.email
    fill_in 'user_password', with: '111'
    fill_in 'user_password_confirmation', with: ''
    click_button 'Salvar'

    expect(page).to have_content('Senha é muito curto (mínimo: 6 caracteres)')
    expect(page).to have_content('Confirmação da senha não é igual a Senha')
  end

  it 'Fail on User with email taken' do
    visit '/'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Acessar'
    click_link 'Criar Usuário', match: :first

    fill_in 'user_name', with: @user_example.name
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user_example.password
    fill_in 'user_password_confirmation', with: @user_example.password
    click_button 'Salvar'

    expect(page).to have_content('E-mail já está em uso')
  end

  it 'Update User' do
    visit '/'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Acessar'
    visit edit_user_path(@user)

    fill_in 'user_name', with: 'Rodrigo'
    fill_in 'user_password', with: 'new_password'
    fill_in 'user_password_confirmation', with: 'new_password'
    click_button 'Salvar'
    expect(page).to have_content(@success_message)
    expect(User.where(email: @user.email).first.name).to eq('Rodrigo')
    expect(page).to have_http_status 200
  end

  it 'Fail on Update User with empty fields' do
    visit '/'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Acessar'
    visit edit_user_path(@user)

    fill_in 'user_email', with: ''
    fill_in 'user_name', with: ''
    fill_in 'user_password', with: ''
    fill_in 'user_password_confirmation', with: ''
    click_button 'Salvar'
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
    expect(page).to have_http_status 200
  end

  it 'Success on Delete User' do
    visit '/'
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'Acessar'
    # expect{
    #   visit :destroy, :id => @user_example.id
    # }.to change(User, :count).by(-1)
    # send(user_path(@user_example), @user_example, { method: :delete })
    # page.driver.delete(user_path(@user_example.id))
  end
end
