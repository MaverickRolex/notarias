require 'rails_helper'

RSpec.describe SegmentsController, type: :controller do
  render_views
  before(:each) do
    @user = User.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password', username: "admin")
    sign_in @user
  end

  context "GET #index" do

    it "returns a success response" do
      get :index
      expect(response).to be_success
    end

    it "render the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "returns a list of segments" do
      segments = create_list(:segment, 3)
      get :index
      expect(assigns(:segments)).to match_array(segments)
    end
    # TODO: add test to probe the relations of parent and childrens for segments 
    # @segment_2.parent_segment = @segment
  end

  describe "GET #show" do

    before(:each) do
      @segment = create(:segment)
    end

    it "returns a successful response" do
      get :show, params: { id: @segment.id }
      expect(response).to be_success
    end

    it "renders the #show template" do
      get :show, params: { id: @segment.id }
      expect(response).to render_template(:show)
    end

    it "returns a segment" do
      get :show, params: { id: @segment.id }
      expect(assigns(:segment)).to be_a(Segment)
    end

    it "returns the requested segment" do
      get :show, params: { id: @segment.id }
      expect(assigns(:segment)).to eql(@segment)
    end
  end
end