FactoryGirl.define do
  sequence :flow_name do |n|
    "flow#{n}"
  end
  factory :flow do
    name {generate :flow_name}
    steps [
     {
            step: 10,
            process: "CONFIRMATION",
            description: "confirmation",
            goto_true: 100,
            params: {
                start: true,
                manual: true,
                msg: "Starta digitalisering"
            }
        },
        {
            step: 100,
            process: "CONFIRMATION",
            description: "confirmation2",
            params: {
                manual: true,
                end: true,
                source_folder_path: "PROCESSING:/123",
                destination_folder_path: "PROCESSING:/111"
            }
        }    
    ].to_json
  end
end
