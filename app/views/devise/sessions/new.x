.span4.offset4
<h2>Sign in</h2>

<%= form_for(resource, :as => resource_name, :url => session_path(resource_name)) do |f| %>
  <div><%= f.label :email %><br />
  <%= f.email_field :email, :autofocus => true %></div>

  <div><%= f.label :password %><br />
  <%= f.password_field :password %></div>

  <% if devise_mapping.rememberable? -%>
    <div><%= f.check_box :remember_me %> <%= f.label :remember_me %></div>
  <% end -%>

  <div><%= f.submit "Sign in" %></div>
<% end %>

<%= render "devise/shared/links" %>
