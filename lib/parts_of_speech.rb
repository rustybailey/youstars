module PartsOfSpeech

  Articles = ['a', 'an', 'the']
  Pronouns = ['i', 'you', 'he', 'she', 'they', 'it', 'me', 'him', 'her', 'them', 'his', 'hers', 'theirs', 'its']
  Prepositions = ['of', 'to', 'at', 'in', 'out']
  CommonWords = ['like', 'likes', 'based']
  Other = ['']

  StopWords = [Articles, Pronouns, Prepositions, CommonWords, Other].flatten

end  
