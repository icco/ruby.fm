class NullObject
  def initialize(*); end
  def method_missing(*); self; end
  def respond_to?(*); true; end
  def to_s; ''; end
  def to_str; ''; end
  def to_i; 0; end
  def to_f; 0.0; end
  def to_c; 0.to_c; end
  def to_r; 0.to_r; end
  def to_a; []; end
  def to_ary; []; end
  def to_h; {}; end
  def nil?; true; end
  def present?; false; end
  def persisted?; false; end
  def empty?; true; end
  def blank?; true; end
  def !; true; end
  def tap
    yield(self)
    self
  end
end
