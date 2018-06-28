post_content = "Lorem **ipsum** dolor sit amet, consectetur adipiscing elit. Proin nibh augue, suscipit a, scelerisque sed, lacinia in, mi. Cras vel lorem. Etiam pellentesque aliquet tellus. Phasellus pharetra nulla ac diam. Quisque semper justo at risus. Donec venenatis, turpis vel hendrerit interdum, dui ligula ultricies purus, sed posuere libero dui id orci. Nam congue, pede vitae dapibus aliquet, elit magna vulputate arcu, vel tempus metus leo non est. Etiam sit amet lectus quis est congue mollis. Phasellus congue lacus eget neque. [Phasellus ornare](http://google.com), ante vitae consectetuer consequat, purus sapien ultricies dolor, et mollis pede metus eget nisi. Praesent sodales velit quis augue. Cras suscipit, urna at aliquam rhoncus, urna quam viverra nisi, in interdum massa nibh nec erat."

user = User.create(provider: 'github', uid: '1234', name: 'Pawel Dabrowski', 
  profile_url: 'https://github.com/rubyhero', image_url: 'https://avatars2.githubusercontent.com/u/238076?v=4'
)

20.times do |i|
  Post.create(title: "Article #{i}", content: post_content, user: user)
end
