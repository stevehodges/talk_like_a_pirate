require 'spec_helper'
include I18nHelperMethods

describe TalkLikeAPirate::I18nTranslator do
	let(:source_locale)   { 'en' }
	let(:instance) { TalkLikeAPirate::I18nTranslator.new(from_locale: source_locale) }
	setup_temp_folder
	after { remove_temp_files }

	describe '#translate_file_or_directory' do
		let(:source_filename) { 'en.yml' }
		let(:source_path)     { nil }

		subject do
			create_source_file source_path, source_filename
			instance.translate_file_or_directory(@temp_folder)
			target_filename = source_filename.sub(source_locale, 'arr')
			tempfile_exists? File.join(*[source_path, target_filename].compact)
		end

		describe 'translated file creation' do
			it { is_expected.to be true }

			context 'prefixed filenames' do
				let(:source_filename) { 'devise.en.yml' }
				it { is_expected.to be true }
			end

			context 'sublocale filenames' do
				let(:source_filename) { 'en-US.yml' }
				it { is_expected.to be true }
			end

			context 'subfolders' do
				let(:source_path)     { 'subfolder' }
				it { is_expected.to be true }
			end

			context 'nested subfolders' do
				let(:source_path)     { 'subfolder/another_subfolder' }
				it { is_expected.to be true }
			end

			context 'multiple source files in folder' do
				before do
					create_source_file '', source_filename_1
					create_source_file '', source_filename_2
				end
				let(:source_filename_1) { 'en.yml' }
				let(:source_filename_2) { 'en-US.yml' }
				it { expect(tempfile_exists?(source_filename_1)).to be true }
				it { expect(tempfile_exists?(source_filename_2)).to be true }
			end
		end

		describe 'yaml top level key' do
			subject do
				create_source_file '', source_filename
				instance.translate_file_or_directory(@temp_folder)
				target_filename = source_filename.sub(source_locale, 'arr')

				yaml_for(target_filename).keys[0]
			end

			it { is_expected.to eq 'arr' }

			context 'prefixed filenames' do
				let(:source_filename) { 'devise.en.yml' }
				it { is_expected.to eq 'arr' }
			end

			context 'sublocale filenames' do
				let(:source_filename) { 'en-US.yml' }
				it { is_expected.to eq 'arr-US' }
			end
		end

		describe 'translations' do
			def subject(yaml_path)
				create_source_file '', 'en.yml'
				instance.translate_file_or_directory(@temp_folder)
				yaml_for('arr.yml').dig *yaml_path
			end
			it { expect(subject(['arr', 'house',  'address'])).to eq "Port o' call"}
			it { expect(subject(['arr', 'house',  'country'])).to eq "Land"}
			it { expect(subject(['arr', 'person', 'employee'])).to eq "Crew"}
			it { expect(subject(['arr', 'person', 'family'])).to eq "kin"}
		end
	end
end