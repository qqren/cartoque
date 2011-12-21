require 'spec_helper'

describe ServerDecorator do
  before do
    @server = Factory.create(:server).decorate
  end

  describe "#badges" do
    it "is empty if the server has no badge" do
      @server.badges.should == ""
    end

    it "concatenates all the badges for a server" do
      @server.network_device = true
      @server.virtual = true
      @server.puppetversion = "2.6"
      badges = @server.badges
      badges.should have_selector("div", :count => 3)
    end
  end

  describe "#network_device_badge" do
    it "is empty for normal servers" do
      @server.network_device_badge.should == ""
    end

    it "displays an image for network devices" do
      @server.network_device = true
      @server.network_device_badge.should have_selector("div>img")
    end
  end
  
  describe "#puppet_badge" do
    it "is empty for non-puppetized servers" do
      @server.puppet_badge.should == ""
    end

    it "displays a P if puppetversion is present" do
      @server.puppetversion = "2.6"
      @server.puppet_badge.should have_selector("div", :text => "P")
    end
  end
  
  describe "#virtual_badge" do
    it "is empty for physical servers" do
      @server.virtual_badge.should == ""
    end

    it "displays a V for virtual machines" do
      @server.virtual = true
      @server.virtual_badge.should have_selector("div", :text => "V")
    end
  end
end
