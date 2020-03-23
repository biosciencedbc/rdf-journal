
require 'erb'

fname = ARGV[0]

output = "#{File.basename(fname)}.ttl"

jid, jt, medabbr, issn_p, issn_o, nlmid = "", "", "", "", "" , ""  

prefix = ["dcterms: <http://purl.org/dc/terms/>", "bibo: <http://purl.org/ontology/bibo/>", "prism: <http://prismstandard.org/namespaces/1.2/basic/>", "fabio: <http://purl.org/spar/fabio/>"]

File.open(output, 'a'){|f|
  prefix.each{ |p| f.puts("@prefix "+ p + " .")}
}

File.open(fname){|file|
  file.each_line{ |line|
    
    #jid
    if /JrId/ === line then
      jid = /JrId:/.match(line).post_match.delete("\n")
    #jt
    elsif /JournalTitle/ === line
      jt = /JournalTitle:/.match(line).post_match.delete("\n")
    #medabbr
    elsif /MedAbbr/ === line then
      medabbr = /MedAbbr:/.match(line).post_match.delete("\n")
    #issn_p
    elsif /ISSN \(Print\)/ === line then
      issn_p = /ISSN \(Print\):/.match(line).post_match.strip
    #issn_o
    elsif /ISSN \(Online\)/ === line then
      issn_o = /ISSN \(Online\):/.match(line).post_match.strip
    #nlmid
    elsif /NlmId/ === line then
      nlmid = /NlmId:/.match(line).post_match.delete("\n")
      
      erb = ERB.new(IO.read("/nlm_catalog_converter.erb"),nil,"%")
      File.open(output, 'a'){|f|
        f.puts erb.result(binding).gsub(/\n(\s| )*\n/, "\n")
      }
    else
      next
    end
  }

}



