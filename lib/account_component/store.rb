module AccountComponent
  class Store
    include EntityStore

    category :account
    entity Account
    projection Projection
    reader MessageStore::Postgres::Read
  end
end
