[
  [1,"作業"],
  [2,"会議"],
  [3,"移動"],
  [4,"休憩"],
  [5,"自宅"],
  [6,"その他"]
].each do |id,name|
    Tag.create!({id: id, name: name})
  end