require 'rails_helper'

RSpec.describe Cell, type: :model do
  it { should belong_to :board }

  it { should validate_presence_of :row }
  it { should validate_presence_of :column }

  subject { FactoryBot.create(:cell) }

  describe '.click!' do
    context 'when can_click? = true' do
      it 'updates clicked' do
        expect { subject.click! }.to change { subject.reload.clicked? }.from(false).to(true)
      end
    end

    context 'when can_click? = false' do
      subject { FactoryBot.create(:cell, clicked: true) }

      it 'returns nil' do
        expect(subject.click!).to be_nil
      end
    end
  end

  describe '.mark!' do
    context 'when can_click? = true' do
      it 'updates clicked' do
        expect { subject.mark! }.to change { subject.reload.flag }.from('empty').to('mark')
      end
    end

    context 'when can_click? = false' do
      subject { FactoryBot.create(:cell, clicked: true) }

      it 'returns nil' do
        expect(subject.mark!).to be_nil
      end
    end
  end

  describe '.red_flag!' do
    context 'when can_click? = true' do
      it 'updates clicked' do
        expect { subject.red_flag! }.to change { subject.reload.flag }.from('empty').to('red')
      end
    end

    context 'when can_click? = false' do
      subject { FactoryBot.create(:cell, clicked: true) }

      it 'returns nil' do
        expect(subject.red_flag!).to be_nil
      end
    end
  end

  describe '.restore_flag!' do
    subject { FactoryBot.create(:cell, flag: :red) }

    context 'when can_click? = true' do
      it 'updates clicked' do
        expect { subject.restore_flag! }.to change { subject.reload.flag }.from('red').to('empty')
      end
    end

    context 'when can_click? = false' do
      subject { FactoryBot.create(:cell, clicked: true) }

      it 'returns nil' do
        expect(subject.restore_flag!).to be_nil
      end
    end
  end
end
