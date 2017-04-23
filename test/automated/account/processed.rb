require_relative '../automated_init'

context "Account" do
  context "Processed" do
    sequence = Controls::Sequence.example

    context "Has not yet processed" do
      context "Account's sequence is lower than the sequence" do
        account = Controls::Account.example(sequence: sequence - 1)

        processed = account.processed?(sequence)

        test do
          refute(processed)
        end
      end

      context "Account's sequence is nil" do
        account = Controls::Account.example(sequence: nil)

        processed = account.processed?(sequence)

        test do
          refute(processed)
        end
      end
    end

    context "Has processed" do
      context "Account's sequence is greater than the sequence" do
        account = Controls::Account.example(sequence: sequence + 1)

        processed = account.processed?(sequence)

        test do
          assert(processed)
        end
      end

      context "Account's sequence is equal to the sequence" do
        account = Controls::Account.example(sequence: sequence)

        processed = account.processed?(sequence)

        test do
          assert(processed)
        end
      end
    end
  end
end
