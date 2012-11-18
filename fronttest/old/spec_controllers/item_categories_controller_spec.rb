require 'spec_helper'

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

describe ItemCategoriesController do

  # This should return the minimal set of attributes required to create a valid
  # ItemCategory. As you add validations to ItemCategory, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ItemCategoriesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all item_categories as @item_categories" do
      item_category = ItemCategory.create! valid_attributes
      get :index, {}, valid_session
      assigns(:item_categories).should eq([item_category])
    end
  end

  describe "GET show" do
    it "assigns the requested item_category as @item_category" do
      item_category = ItemCategory.create! valid_attributes
      get :show, {:id => item_category.to_param}, valid_session
      assigns(:item_category).should eq(item_category)
    end
  end

  describe "GET new" do
    it "assigns a new item_category as @item_category" do
      get :new, {}, valid_session
      assigns(:item_category).should be_a_new(ItemCategory)
    end
  end

  describe "GET edit" do
    it "assigns the requested item_category as @item_category" do
      item_category = ItemCategory.create! valid_attributes
      get :edit, {:id => item_category.to_param}, valid_session
      assigns(:item_category).should eq(item_category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ItemCategory" do
        expect {
          post :create, {:item_category => valid_attributes}, valid_session
        }.to change(ItemCategory, :count).by(1)
      end

      it "assigns a newly created item_category as @item_category" do
        post :create, {:item_category => valid_attributes}, valid_session
        assigns(:item_category).should be_a(ItemCategory)
        assigns(:item_category).should be_persisted
      end

      it "redirects to the created item_category" do
        post :create, {:item_category => valid_attributes}, valid_session
        response.should redirect_to(ItemCategory.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved item_category as @item_category" do
        # Trigger the behavior that occurs when invalid params are submitted
        ItemCategory.any_instance.stub(:save).and_return(false)
        post :create, {:item_category => {}}, valid_session
        assigns(:item_category).should be_a_new(ItemCategory)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ItemCategory.any_instance.stub(:save).and_return(false)
        post :create, {:item_category => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested item_category" do
        item_category = ItemCategory.create! valid_attributes
        # Assuming there are no other item_categories in the database, this
        # specifies that the ItemCategory created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ItemCategory.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => item_category.to_param, :item_category => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested item_category as @item_category" do
        item_category = ItemCategory.create! valid_attributes
        put :update, {:id => item_category.to_param, :item_category => valid_attributes}, valid_session
        assigns(:item_category).should eq(item_category)
      end

      it "redirects to the item_category" do
        item_category = ItemCategory.create! valid_attributes
        put :update, {:id => item_category.to_param, :item_category => valid_attributes}, valid_session
        response.should redirect_to(item_category)
      end
    end

    describe "with invalid params" do
      it "assigns the item_category as @item_category" do
        item_category = ItemCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ItemCategory.any_instance.stub(:save).and_return(false)
        put :update, {:id => item_category.to_param, :item_category => {}}, valid_session
        assigns(:item_category).should eq(item_category)
      end

      it "re-renders the 'edit' template" do
        item_category = ItemCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ItemCategory.any_instance.stub(:save).and_return(false)
        put :update, {:id => item_category.to_param, :item_category => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested item_category" do
      item_category = ItemCategory.create! valid_attributes
      expect {
        delete :destroy, {:id => item_category.to_param}, valid_session
      }.to change(ItemCategory, :count).by(-1)
    end

    it "redirects to the item_categories list" do
      item_category = ItemCategory.create! valid_attributes
      delete :destroy, {:id => item_category.to_param}, valid_session
      response.should redirect_to(item_categories_url)
    end
  end

end
