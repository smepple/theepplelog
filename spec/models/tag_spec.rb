# == Schema Information
#
# Table name: tags
#
#  id   :integer          not null, primary key
#  name :string(255)
#

require 'spec_helper'

describe Tag do
  
  before { @tag = Tag.create!(name: "test_tag") }

  subject { @tag }

  it { should be_valid }

  it { should respond_to :name }
end
