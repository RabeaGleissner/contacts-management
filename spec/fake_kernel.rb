class FakeKernel
  attr_reader :exit_was_called

  def initialize
    @exit_was_called = false
  end

  def exit
    @exit_was_called = true
  end
end
