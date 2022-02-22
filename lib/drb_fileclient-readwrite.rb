#!/usr/bin/env ruby

# file: drb_fileclient-readwrite.rb

require 'drb_fileclient-reader'


class DRbFileClientReadWrite < DRbFileClientReader
  using ColouredText

  def glob(s)

    if s =~ /^dfs:\/\// then
      @file, s2 = parse_path(s)
    else
      s2 = File.join(@directory, s)
    end

    @file.glob s2

  end
  
  def mkdir(name)
    
    return FileUtils.mkdir name unless @directory or name =~ /^dfs:\/\//
    
    @file, path = parse_path(name)
    @file.mkdir path
  end
  
  def mkdir_p(raw_path)
    
    unless @directory or raw_path =~ /^dfs:\/\// then
      return FileUtils.mkdir_p raw_path 
    end    
    
    if raw_path =~ /^dfs:\/\// then
      @file, filepath = parse_path(raw_path)
    else
      filepath = File.join(@directory, raw_path)
    end
    
    @file.mkdir_p filepath
  end
  
  def rm(path)
    
    return FileUtils.rm path unless @directory or path =~ /^dfs:\/\//
    
    if path =~ /^dfs:\/\// then
      @file, path2 = parse_path( path)
    else
      path2 = File.join(@directory, path)
    end
      
    @file.rm  path2
    
  end    

  def rm_r(path, force: false)

    unless @directory or path =~ /^dfs:\/\// then
      return FileUtils.rm_r(path, force: force)
    end

    if path =~ /^dfs:\/\// then
      @file, path2 = parse_path( path)
    else
      path2 = File.join(@directory, path)
    end

    @file.rm_r(path2, force: force)

  end

  def touch(s, mtime: Time.now)

    unless @directory or s =~ /^dfs:\/\// then
      return FileUtils.touch(s, mtime: mtime)
    end

    if s =~ /^dfs:\/\// then
      @file, s2 = parse_path(s)
    else
      s2 = File.join(@directory, s)
    end

    @file.touch s2, mtime: mtime

  end
  
  def write(filename=@filename, s)
        
    return File.write filename, s unless @directory or filename =~ /^dfs:\/\//
    
    if filename =~ /^dfs:\/\// then
      @file, path = parse_path(filename)
    else
      path = File.join(@directory, filename)
    end
    
    @file.write path, s     
    
  end

end 

  
def DfsFile.glob(s)
  DRbFileClientReadWrite.new.glob(s)
end

def DfsFile.rm(filename)
  DRbFileClientReadWrite.new.rm(filename)
end

def DfsFile.rm_r(filename, force: false)
  DRbFileClientReadWrite.new.rm_r(filename, force: force)
end

def DfsFile.touch(filename, mtime: Time.now)
  DRbFileClientReadWrite.new.touch(filename, mtime: mtime)
end

def DfsFile.write(filename, s)
  DRbFileClientReadWrite.new.write(filename, s)
end
