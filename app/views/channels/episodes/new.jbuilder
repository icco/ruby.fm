json.data do
  json.uploader do
    json.key(@uploader.key)
    json.aws_access_key_id(@uploader.aws_access_key_id)
    json.acl(@uploader.acl)
    json.success_action_status(@uploader.success_action_status)
    json.policy(@uploader.policy)
    json.signature(@uploader.signature)
  end
end
