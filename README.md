# Inactive Record

```sh
irb -r ./inactive_record.rb
```

```rb
class Project < InactiveRecord::Base
  belongs_to :user
end

class User < InactiveRecord::Base
  has_many :projects
end

User.where(admin: true).first.projects.order(:name).map(&:name)
```
