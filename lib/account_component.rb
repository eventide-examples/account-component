require 'eventide/postgres'
require 'consumer/postgres'
require 'try'

require 'account_component/messages/commands/open'
require 'account_component/messages/commands/deposit'
require 'account_component/messages/commands/withdraw'
require 'account_component/messages/commands/close'
require 'account_component/messages/events/opened'
require 'account_component/messages/events/deposited'
require 'account_component/messages/events/withdrawn'
require 'account_component/messages/events/withdrawal_rejected'
require 'account_component/messages/events/closed'

require 'account_component/account'
require 'account_component/projection'
require 'account_component/store'

require 'account_component/handlers/commands'
require 'account_component/handlers/commands/transactions'

require 'account_component/consumers/commands'
require 'account_component/consumers/commands/transactions'

require 'account_component/start'
