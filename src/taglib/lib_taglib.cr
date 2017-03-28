@[Link("tag_c")]

lib LibTagLib
  alias CChar = LibC::Char
  alias CShort = LibC::Int16T
  alias CInt = LibC::Int32T
  alias CUInt = LibC::UInt32T
  alias CLong = LibC::Int64T
  alias CULong = LibC::UInt64T
  alias CFloat = LibC::Float
  alias CDouble = LibC::Double

  enum TagLib_File_Type
    MPEG
    OggVorbis
    FLAC
    MPC
    OggFlac
    WavPack
    Speex
    TrueAudio
    MP4
    ASF
    Type
  end

  enum TagLib_ID3v2_Encoding
    Latin1
    UTF16
    UTF16BE
    UTF8
  end

  struct Tags
    title : CChar*
    artist : CChar*
    album : CChar*
    comment : CChar*
    genre : CChar*
    year : CInt
    track : CInt
  end

  struct Properties
    length : CInt
    bitrate : CInt
    samplerate : CInt
    channels : CInt
  end

  struct TagLib_File
    dummy : CInt
  end

  struct TagLib_Tag
    dummy : CInt
  end

  struct TagLib_AudioProperties
    dummy : CInt
  end

  fun taglib_set_strings_unicode(CInt)
  fun taglib_free(Void*)
  fun taglib_file_new(CChar*) : TagLib_File*
  fun taglib_file_new_type(CChar*, TagLib_File_Type) : TagLib_File*
  fun taglib_file_free(TagLib_File*)
  fun taglib_file_is_valid(TagLib_File*) : CInt
  fun taglib_file_tag(TagLib_File*) : TagLib_Tag*
  fun taglib_file_audioproperties(TagLib_File*) : TagLib_AudioProperties*
  fun taglib_file_save(TagLib_File*) : CInt

  fun taglib_tag_title(TagLib_Tag*) : CChar*
  fun taglib_tag_artist(TagLib_Tag*) : CChar*
  fun taglib_tag_album(TagLib_Tag*) : CChar*
  fun taglib_tag_comment(TagLib_Tag*) : CChar*
  fun taglib_tag_genre(TagLib_Tag*) : CChar*
  fun taglib_tag_year(TagLib_Tag*) : CUInt
  fun taglib_tag_track(TagLib_Tag*) : CUInt
  fun taglib_tag_set_title(TagLib_Tag*, CChar*)
  fun taglib_tag_set_artist(TagLib_Tag*, CChar*)
  fun taglib_tag_set_album(TagLib_Tag*, CChar*)
  fun taglib_tag_set_comment(TagLib_Tag*, CChar*)
  fun taglib_tag_set_genre(TagLib_Tag*, CChar*)
  fun taglib_tag_set_year(TagLib_Tag*, CUInt)
  fun taglib_tag_set_track(TagLib_Tag*, CUInt)
  fun taglib_tag_free_strings
  fun taglib_audioproperties_length(TagLib_AudioProperties*) : CInt
  fun taglib_audioproperties_bitrate(TagLib_AudioProperties*) : CInt
  fun taglib_audioproperties_samplerate(TagLib_AudioProperties*) : CInt
  fun taglib_audioproperties_channels(TagLib_AudioProperties*) : CInt
  fun taglib_id3v2_set_default_text_encoding(TagLib_ID3v2_Encoding)
end
