package com.somerandomdude.coordy.constants;

class FlowOverflowPolicy
{

  /**
   * Allow all nodes within flow that are out of the layout's bounds to continue flowing.
   * For example, a flow layout in which the <em>flowDirection</em> was <em>HORIZONTAL</em> would continue
   * places nodes horizontally even if the bounds of the layout have been reached
   */
  public static inline var ALLOW_OVERFLOW:String="allow";

  /**
   * Will simply not place nodes that do not fit within the layout's bounds.
   */
  public static inline var IGNORE_OVERFLOW:String="ignore";

  /**
   * Will remove node's DisplayObject link from the target's display stack if it does not
   * fit within that layout's bounds.
   */
  public static inline var HIDE_OVERFLOW:String="hide";

}
