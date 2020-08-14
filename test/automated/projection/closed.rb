require_relative '../automated_init'

context "Projection" do
  context "Closed" do
    account = Controls::Account.example

    assert(account.closed_time.nil?)

    projection = Projection.build(account)
    closed = Controls::Events::Closed.example

    fixture(
      EntityProjection::Fixtures::Projection,
      projection,
      closed
    ) do |fixture|
      fixture.assert_transformed_and_copied(:time => :closed_time) { |v| Time.parse(v) }
    end
  end
end
