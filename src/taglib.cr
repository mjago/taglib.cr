require "./taglib/*"

module TagLib
  def self.set_strings_unicode(trueorfalse : Bool)
    ret = trueorfalse ? 1 : 0
    LibTagLib.taglib_set_strings_unicode(ret)
  end

  def self.free_strings
    LibTagLib.taglib_tag_free_strings
  end

  def tag_free(arg : Void*)
    LibTagLib.taglib_free(arg)
  end

  def tag_id3v2_set_default_text_encoding(enc : ID3v2Encoding)
    LibTagLib.taglib_id3v2_set_default_text_encoding(enc)
  end

  class File
    alias FileType = LibTagLib::TagLib_File_Type
    alias ID3v2Encoding = LibTagLib::TagLib_ID3v2_Encoding
    alias TagFile = LibTagLib::TagLib_File
    alias Tag = LibTagLib::TagLib_Tag

    getter tags

    @tagfile : TagFile*

    def initialize(name)
      @tagfile = init(name)
    end

    def init(name : String) : TagFile*
      LibTagLib.taglib_file_new(name)
    end

    #    def new_type(arg : Char*, typ : FileType) : TagFile*
    #      LibTagLib.taglib_file_new_type(arg, typ)
    #    end

    def free()
      LibTagLib.taglib_file_free(@tagfile)
    end

    def is_valid? : Bool
      x = LibTagLib.taglib_file_is_valid(@tagfile)
      x == 0 ? false : true
    end

    def load_tags
      @tags = FileTag.new(file_tag)
    end

    def save_tags : Bool
      x = LibTagLib.taglib_file_save(@tagfile)
      x == 0 ? false : true
    end

    def tags
      if tags = @tags
        tags
      else
        raise "Error: tags must be loaded with #load_tags!"
      end
    end

    def audio_properties
      @audio_properties ||= AudioProperties.new(@tagfile)
      if props = @audio_properties
        props
      else
        raise "Error loading audio properties!"
      end
    end

    def file_tag : Tag*
      LibTagLib.taglib_file_tag(@tagfile)
    end
  end

  # Tag API
  class FileTag

    alias Tag = LibTagLib::TagLib_Tag

    @tag : Tag*

    def initialize(filetag)
      @tag = filetag
    end

    def title() : String
      String.new(LibTagLib.taglib_tag_title(@tag))
    end

    def artist() : String
      String.new(LibTagLib.taglib_tag_artist(@tag))
    end

    def album() : String
      String.new(LibTagLib.taglib_tag_album(@tag))
    end

    def comment() : String
      String.new(LibTagLib.taglib_tag_comment(@tag))
    end

    def genre() : String
      String.new(LibTagLib.taglib_tag_genre(@tag))
    end

    def year() : Int
      LibTagLib.taglib_tag_year(@tag)
    end

    def track() : Int
      LibTagLib.taglib_tag_track(@tag)
    end

    def title=(title : String)
      LibTagLib.taglib_tag_set_title(@tag, title)
    end

    def artist=(artist : String)
      LibTagLib.taglib_tag_set_artist(@tag, artist)
    end

    def album=(album : String)
      LibTagLib.taglib_tag_set_album(@tag, album)
    end

    def comment=(comment : String)
      LibTagLib.taglib_tag_set_comment(@tag, comment)
    end

    def genre=(genre : String)
      LibTagLib.taglib_tag_set_genre(@tag, genre)
    end

    def year=(year : Int)
      LibTagLib.taglib_tag_set_year(@tag, year.to_u32)
    end

    def track=(track : Int)
      LibTagLib.taglib_tag_set_track(@tag, track)
    end

  end

  class AudioProperties

    alias TagFile = LibTagLib::TagLib_File
    alias AudioProps = LibTagLib::TagLib_AudioProperties

    @audio_props : AudioProps*

    def initialize(file : TagFile*) : AudioProps*
      @audio_props = audio_properties(file)
    end

    private def audio_properties(file) : AudioProps*
      LibTagLib.taglib_file_audioproperties(file)
    end

    def length : Int
      LibTagLib.taglib_audioproperties_length(@audio_props)
    end

    def bitrate : Int
      LibTagLib.taglib_audioproperties_bitrate(@audio_props)
    end

    def samplerate : Int
      LibTagLib.taglib_audioproperties_samplerate(@audio_props)
    end

    def channels : Int
      LibTagLib.taglib_audioproperties_channels(@audio_props)
    end
  end
end
