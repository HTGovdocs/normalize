
def normalize_corporate( corp )
  ag = corp.upcase; 
  ag.gsub!(/[,\.:;]|\'S?/, '');   # punctuations
  ag.gsub!(/[\(\)\{\}\[\]]/, ''); # Brackets
  ag.gsub!(/FOR SALE BY/, '');  # I AM NOT INTERESTED IN WHAT YOU ARE SELLING. #some are GPO
  ag.gsub!(/\b(THE) /, '');       # Stop words

  # Abbreviations et cetera.
  ag.gsub!(/DEPARTMENT/, 'DEPT');
  ag.gsub!(/DEPTOF/, 'DEPT OF'); # Strangely common typo(?)

  ag.gsub!(/&(AMP)?/, ' AND ');

  ag.gsub!(/UNITED STATES( OF AMERICA)?/, 'UNITED STATES');
  ag.gsub!(/\bUS\b/, 'UNITED STATES'); #dangerous?
  ag.gsub!(/U\sS\s|U S$/, 'UNITED STATES ');
  ag.gsub!(/GOVT/, 'GOVERNMENT');
  ag.gsub!(/ SPN$/, '');

  # US GOVT PRINT OFF, which is so common yet has so many variations.
  ag.sub!(/(US\s?)?GOVT\s?PRINT(ING)?\s?OFF(ICE)?/, 'USGPO');
  ag.sub!(/U\s?S\s?G\s?P\s?O/, 'USGPO');
  ag.sub!(/^GPO$/, 'USGPO');
  
  #mostly congressional stuff
  ag.sub!(/(\d?)2D/, '\12ND'); 
  ag.sub!(/(\d?)3D/, '\13RD'); 
  ag.sub!(/\b(CONG)\b/, 'CONGRESS');
  ag.sub!(/\b(SESS)\b/, 'SESSION');
  ag.sub!(/\b(\d+[A-Z]{2}) CONGRESS\b/, 'CONGRESS \1'); #congress then session info

  #authorities drop the inc, so we probably should too
  ag.sub!(/\b(INC)$/, ''); 


  ag.gsub!(/ +/, ' '); # whitespace
  ag.sub!(/^ +/,  '');
  ag.sub!(/ +$/,  '');

  return ag

end



