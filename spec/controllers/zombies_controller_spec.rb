require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe ZombiesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Zombie. As you add validations to Zombie, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryBot.attributes_for(:zombie)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:zombie, name: nil)
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ZombiesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response', :show_in_doc do
      Zombie.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end

    it 'returns a 10 elements', :show_in_doc do
      FactoryBot.create_list(:zombie, 50)
      get :index,
          params: { page: 1, per_page: 10 },
          session: valid_session
      zombies = JSON.parse(response.body)
      expect(zombies.count).to eq(10)
    end
  end

  describe 'GET #show' do
    it 'returns a success response', :show_in_doc do
      zombie = Zombie.create! valid_attributes
      get :show,
          params: { id: zombie.to_param },
          session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Zombie', :show_in_doc do
        expect {
          post :create, params: { zombie: valid_attributes }, session: valid_session
        }.to change(Zombie, :count).by(1)
      end

      it 'renders a JSON response with the new zombie', :show_in_doc do

        post :create,
             params: { zombie: valid_attributes },
             session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(zombie_url(Zombie.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for new zombie', :show_in_doc do

        post :create,
             params: { zombie: invalid_attributes },
             session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        FactoryBot.attributes_for(:zombie)
      }

      it 'updates the requested zombie', :show_in_doc do
        zombie = Zombie.create! valid_attributes
        update_attributes = new_attributes
        put :update,
            params: { id: zombie.to_param, zombie: update_attributes },
            session: valid_session
        zombie.reload
        expect(zombie.name).to eq(new_attributes[:name])
        expect(zombie.hit_points).to eq(new_attributes[:hit_points])
        expect(zombie.speed).to eq(new_attributes[:speed])
        expect(zombie.brains_eaten).to eq(new_attributes[:brains_eaten])
        expect(zombie.turn_date).to eq(new_attributes[:turn_date])
      end

      it 'renders a JSON response with the zombie', :show_in_doc do
        zombie = Zombie.create! valid_attributes

        put :update,
            params: { id: zombie.to_param, zombie: valid_attributes },
            session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the zombie', :show_in_doc do
        zombie = Zombie.create! valid_attributes

        put :update,
            params: { id: zombie.to_param, zombie: invalid_attributes },
            session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested zombie', :show_in_doc do
      zombie = Zombie.create! valid_attributes
      expect {
        delete :destroy, params: { id: zombie.to_param }, session: valid_session
      }.to change(Zombie, :count).by(-1)
    end
  end

  describe 'POST #add_armors' do
    it 'add specific armors to specific zombie', :show_in_doc do
      zombie = Zombie.create! valid_attributes
      armor_ids = FactoryBot.create_list(:armor, 3).pluck(:id)
      post :add_armors,
           params: { id: zombie.to_param, armor_ids: armor_ids },
           session: valid_session
      zombie.reload
      expect(zombie.armors.count).to eq(3)
    end
  end

  describe 'POST #add_weapons' do
    it 'add specific weapons to specific zombie', :show_in_doc do
      zombie = Zombie.create! valid_attributes
      weapon_ids = FactoryBot.create_list(:weapon, 3).pluck(:id)
      post :add_weapons,
           params: { id: zombie.to_param, weapon_ids: weapon_ids },
           session: valid_session
      zombie.reload
      expect(zombie.weapons.count).to eq(3)
    end
  end

  describe 'POST #eat_brain' do
    it 'should increment brains_eaten field', :show_in_doc do
      zombie = Zombie.create! valid_attributes
      brains_eaten = zombie.brains_eaten
      post :eat_brain, params: { id: zombie.to_param }, session: valid_session
      zombie.reload
      expect(zombie.brains_eaten).to eq(brains_eaten + 1)
    end
  end
end
