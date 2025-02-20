module gx

// TODO: remove these and uae the enum everywhere
pub const (
	align_left  = HorizontalAlign.left
	align_right = HorizontalAlign.right
)

pub struct TextCfg {
pub:
	color          Color = black
	size           int   = 16
	align          HorizontalAlign = .left
	vertical_align VerticalAlign   = .top
	max_width      int
	family         string
	bold           bool
	mono           bool
	italic         bool
}
