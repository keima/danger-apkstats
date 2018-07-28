module Apkstats::Command
  module Executable
    require "open3"

    attr_reader :command_path

    def exist?
      File.exist?(command_path)
    end

    # Compare two apk files and return results.
    #
    # {
    #   base: {
    #     file_size: Integer,
    #     download_size: Integer,
    #     required_features: Array<String>,
    #     non_required_features: Array<String>,
    #     permissions: Array<String>,
    #     min_sdk: String,
    #     target_sdk: String,
    #   },
    #   other: {
    #     file_size: Integer,
    #     download_size: Integer,
    #     required_features: Array<String>,
    #     non_required_features: Array<String>,
    #     permissions: Array<String>,
    #     min_sdk: String,
    #     target_sdk: String,
    #   },
    #   diff: {
    #     file_size: Integer,
    #     download_size: Integer,
    #     required_features: {
    #       new: Array<String>,
    #       removed: Array<String>,
    #     },
    #     non_required_features:{
    #       new: Array<String>,
    #       removed: Array<String>,
    #     },
    #     permissions: {
    #       new: Array<String>,
    #       removed: Array<String>,
    #     },
    #     min_sdk: Array<String>,
    #     target_sdk: Array<String>,
    #   }
    # }
    #
    # @return [Hash]
    def compare_with(apk_filepath, other_apk_filepath)
      base = Apkstats::Entity::ApkInfo.new(self, apk_filepath)
      other = Apkstats::Entity::ApkInfo.new(self, other_apk_filepath)

      Apkstats::Entity::ApkInfoDiff.new(base, other).to_h
    end
  end
end
