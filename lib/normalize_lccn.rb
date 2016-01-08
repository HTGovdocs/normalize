#Don't use this. Use Bill Dueber's stnum library at 
#https://github.com/billdueber/library_stdnums

#implements http://www.loc.gov/marc/lccn-namespace.html

def normalize_lccn lccn 
  # Lowercase is the rule. May be more appropriate to fail on uppercase. 
  # ~jstever@umich
  lccn.downcase!

  # 1. Remove all blanks.
  lccn.gsub!(/ /, '')

  # 2. If there is a forward slash (/) in the string, remove it, and remove 
  # all characters to the right of the forward slash.
  lccn.gsub!(/\/.*/, '')

  # 3. If there is a hyphen in the string:
  if lccn =~ /-/
    # Remove it.
    # Inspect the substring following (to the right of) the (removed) hyphen. 
    # Then (and assuming that steps 1 and 2 have been carried out):
    #   All these characters should be digits, and there should be six or less.
    #   If the length of the substring is less than 6, left-fill the substring 
    #   with zeros until the length is six.
    parts = lccn.split(/-/, -1)
    if parts[1] =~ /\D/ or parts[1].length > 6
      fail ArgumentError, "Invalid LCCN."
    end
    lccn = parts[0] + parts[1].rjust(6, "0")
  end

  check_syntax lccn

  return lccn
end
     

def check_syntax lccn
  # A normalized LCCN is a character string eight to twelve characters in 
  # length. (For purposes of this description characters are ordered from left 
  # to right -- "first" means "leftmost".)
  if lccn.length > 12 or lccn.length < 8
    fail ArgumentError, "Invalid LCCN."
  end

  # The rightmost eight characters are always digits. 
  if lccn[-8..-1] =~ /\D/
    fail ArgumentError, "Invalid LCCN."
  end

  # If the length is 9, then the first character must be alphabetic.
  if lccn.length == 9 and lccn[0] =~ /[^a-z]/
    fail ArgumentError, "Invalid LCCN."
  end

  # If the length is 10, then the first two characters must be either both 
  # digits or both alphabetic.
  if lccn.length == 10 and !(lccn[0..1] =~ /[a-z]{2}/ or lccn[0..1] =~ /\d{2}/)
    fail ArgumentError, "Invalid LCCN."
  end

  # If the length is 11, then the first character must be alphabetic and the 
  # next two characters must be either both digits or both alphabetic.
  if lccn.length == 11 and lccn[0] =~ /^[a-z]/
    fail ArgumentError, "Invalid LCCN."
  end
  if lccn.length == 11 and !(lccn[1..2] =~ /[a-z]{2}/ or lccn[0..1] =~ /\d{2}/)
    fail ArgumentError, "Invalid LCCN."
  end

  # If the length is 12, then the first two characters must be alphabetic and 
  # the remaining characters digits.
  if lccn.length == 12 and (lccn[0..1] =~ /[^a-z]/ or lccn[2..-1] =~ /\D/)
    fail ArgumentError, "Invalid LCCN."
  end
end




