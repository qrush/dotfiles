function! ERubyIterVar(collection)
  " remove leading space
  let collection = substitute(a:collection,"^\\s\\+","","")
  " remove chains like post.users
  let collection = substitute(collection,"^.*\\.","","")
  " remove instance variable punctuation
  let collection = substitute(collection,"^@","","")
  " singularize
  return rails#singularize(collection)
endfunction

function! PrefixWithKeyArgument(text)
  return ToTranslateKey(a:text) . '", :default => "' . a:text
endfunction

" general erb
Snippet each <% <{collection}>.each do |<{collection:ERubyIterVar(@z)}>| -%><CR><{}><CR><% end -%>
Snippet = <%= <{}> %>
Snippet if <% if <{}> -%><CR><CR><% end -%>
Snippet ifelse <% if <{}> -%><CR><CR><% else -%><CR><% end -%>
Snippet unless <% unless <{}> -%><CR><CR><% end -%>

" rails
Snippet h <%=h <{}> %>
Snippet rp <%= render :partial => '<{}>' %>
Snippet lt <%= link_to <{caption}>, <{}> %>
Snippet ctf <%= content_tag_for :<{tag}>, <{object}> do -%><CR><{}><CR><% end -%>
Snippet cf <% content_for :<{capture}> do -%><CR><{}><CR><% end -%>
Snippet cfj <% content_for :javascript do -%><CR><script type="text/javascript"><CR><{}><CR></script><CR><% end -%>

" formtastic
Snippet sff <%= semantic_form_for <{object}> do |form| -%><CR><%= form.inputs do -%><CR><{}><CR><% end -%><CR><CR><%= form.buttons do -%><CR><%= form.commit_button %><CR><% end -%><CR><% end -%>
Snippet input <%= form.input :<{}> %>

" translation

Snippet t t("<{text:PrefixWithKeyArgument(@z)}>")<{}>

