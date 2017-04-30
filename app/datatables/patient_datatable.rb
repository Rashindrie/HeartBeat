class PatientDatatable < AjaxDatatablesRails::Base

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format

      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      @view_columns ||= {
          id: { source: "Patient.id", cond: :eq },
          full_name: { source: "Patient.full_name" }
    }
  end

  def data
    records.map do |record|
      {
          id: patient.id,
          full_name: patient.full_name
      }
    end
  end

  private

  def get_raw_records
    Patient.select('patients.*')
  end

  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_records(records)
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
