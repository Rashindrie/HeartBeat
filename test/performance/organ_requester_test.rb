require 'test_helper'
require 'rails/performance_test_help'

class OrganRequesterTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 5, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance', formats: [:flat] }

  test "AddRequestStatus" do
    wl=WaitingList.create time_slot_id: '1', patient_id: '1'
    wl=WaitingList.create time_slot_id: '1', patient_id: '1'
    wl=WaitingList.create time_slot_id: '1', patient_id: '1'
    wl=WaitingList.create time_slot_id: '1', patient_id: '1'
    wl=WaitingList.create time_slot_id: '1', patient_id: '1'
    wl=WaitingList.create time_slot_id: '1', patient_id: '1'
    wl=WaitingList.create time_slot_id: '1', patient_id: '1'
    wl=WaitingList.create time_slot_id: '1', patient_id: '1'
    wl=WaitingList.create time_slot_id: '1', patient_id: '1'
    wl=WaitingList.create time_slot_id: '1', patient_id: '1'
    wl=WaitingList.create time_slot_id: '1', patient_id: '1'

  end
end
