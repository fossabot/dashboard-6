Course.current = Course.find(5)

data = [
    { uuid: "119", amount: 6 },
    { uuid: "12e", amount: 2 },
    { uuid: "131", amount: 3 },
    { uuid: "132", amount: 5 },
    { uuid: "138", amount: 5 },
    { uuid: "139", amount: 4 },
    { uuid: "140", amount: 7 },
    { uuid: "144", amount: 2 },
    { uuid: "14b", amount: 3 },
    { uuid: "151", amount: 4 },
    { uuid: "15c", amount: 4 },
    { uuid: "197", amount: 4 },
    { uuid: "19e", amount: 2 },
    { uuid: "1f2", amount: 5 },
    { uuid: "1f3", amount: 3 },
    { uuid: "1f4", amount: 8 },
    { uuid: "1f5", amount: 5 },
    { uuid: "1f6", amount: 6 },
    { uuid: "1f7", amount: 2 },
    { uuid: "1f8", amount: 3 },
    { uuid: "1f9", amount: 8 },
    { uuid: "1fa", amount: 6 },
    { uuid: "1fb", amount: 8 },
    { uuid: "1fc", amount: 3 },
    { uuid: "1fd", amount: 5 },
    { uuid: "1fe", amount: 2 },
    { uuid: "1ff", amount: 1 },
    { uuid: "200", amount: 4 },
    { uuid: "201", amount: 4 },
    { uuid: "202", amount: 4 },
    { uuid: "203", amount: 8 },
    { uuid: "204", amount: 5 },
    { uuid: "205", amount: 6 },
    { uuid: "206", amount: 6 },
    { uuid: "207", amount: 2 },
    { uuid: "208", amount: 5 },
    { uuid: "209", amount: 5 },
    { uuid: "20a", amount: 8 },
    { uuid: "20b", amount: 8 },
    { uuid: "20c", amount: 5 },
    { uuid: "20d", amount: 4 },
    { uuid: "20e", amount: 5 },
    { uuid: "20f", amount: 8 },
    { uuid: "210", amount: 7 },
    { uuid: "211", amount: 1 },
    { uuid: "212", amount: 3 },
    { uuid: "213", amount: 3 },
    { uuid: "214", amount: 5 },
    { uuid: "215", amount: 4 },
    { uuid: "217", amount: 8 },
    { uuid: "218", amount: 7 },
    { uuid: "219", amount: 6 },
    { uuid: "21a", amount: 2 },
    { uuid: "21b", amount: 4 },
    { uuid: "21c", amount: 8 },
    { uuid: "21d", amount: 8 },
    { uuid: "21e", amount: 4 },
    { uuid: "21f", amount: 8 },
    { uuid: "220", amount: 2 },
    { uuid: "221", amount: 5 },
    { uuid: "222", amount: 7 },
    { uuid: "223", amount: 2 },
    { uuid: "225", amount: 5 },
    { uuid: "226", amount: 8 },
    { uuid: "227", amount: 4 },
    { uuid: "228", amount: 6 },
    { uuid: "229", amount: 8 },
    { uuid: "22a", amount: 3 },
    { uuid: "22b", amount: 5 },
    { uuid: "22c", amount: 4 },
    { uuid: "22e", amount: 5 }
]

event = Event.find(29)

data.each do |datum|
  user = User.find_by(uuid: datum[:uuid].upcase)

  datum[:amount].times.each do |_|
    user.register(event)
  end
end
