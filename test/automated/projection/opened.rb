require_relative '../automated_init'

context "Projection" do
  context "Opened" do
    account = Controls::Account::New.example

    assert(account.opened_time.nil?)

    projection = Projection.build(account)
    opened = Controls::Events::Opened.example

    fixture(
      EntityProjection::Fixtures::Projection,
      projection,
      opened
    ) do |fixture|
      fixture.assert_attributes_copied([
        { :account_id => :id },
        :customer_id
      ])

      fixture.assert_transformed_and_copied(:time => :opened_time) { |v| Time.parse(v) }
    end
  end
end
