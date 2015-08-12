require 'rails_helper'

describe ApplicationHelper do
  describe '#bootstrap_class_for' do
    context 'when known flash_type' do
      it 'should return the appropriate class for the alert flash_type' do
        expect(helper.bootstrap_class_for('alert')).to eq('alert-warning')
      end

      it 'should return the appropriate class for the error flash_type' do
        expect(helper.bootstrap_class_for('error')).to eq('alert-danger')
      end

      it 'should return the appropriate class for the notice flash_type' do
        expect(helper.bootstrap_class_for('notice')).to eq('alert-info')
      end

      it 'should return the appropriate class for the success flash_type' do
        expect(helper.bootstrap_class_for('success')).to eq('alert-success')
      end
    end

    context 'when unknown flash_type' do
      it 'should return the class as the flash_type that was given' do
        expect(helper.bootstrap_class_for('test')).to eq('test')
      end
    end
  end

  describe '#page_header' do
    context 'when title is provided' do
      it 'should return the set title' do
        allow(helper).to receive(:content_for).with(:title).and_return('Test')

        expect(helper.page_header).to eq 'Test'
      end
    end

    context 'when title is not provided' do
      it 'should return blank' do
        expect(helper.page_header).to be_blank
      end
    end
  end
end
