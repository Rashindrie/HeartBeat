class RemoveColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column("time_slots", "amount")

    remove_column("appointments", "notification_params")
    remove_column("appointments", "payment_status")
    remove_column("appointments", "transaction_id")
    remove_column("appointments", "purchased_at")


  end
end
