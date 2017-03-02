require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "Gregory", email: "gregory@example.com", password: "password", password_confirmation: "password")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chef should have a name" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end

  test "name should be less than 30 charatures" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end

  test "name should be greater than two charatures" do
    @chef.chefname = "a"
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end

  test "email should be valid format" do
    valid_emails = %w[user@exmple.com greg@gmail.com john@yahoo.ca bill.smith@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end

  test "shoul reject invalid email formats" do
    invalid_emails = %w[user@exmple greggmail.com john@yahoo,ca bill.smith_at_co.uk.org]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be regected"
    end
  end

  test "email should be unique" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "emails should be saved as lowercase" do
    mixed_email = "JohN@Example.Com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end

  test "password should be present" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end
  
  test "password should be atleast 5 character" do
    @chef.password = @chef.password_confirmation = "x" * 4
    assert_not @chef.valid?
  end

end