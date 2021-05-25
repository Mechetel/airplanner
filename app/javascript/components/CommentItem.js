import React, { Component } from "react"
import PropTypes from "prop-types"
import { bindActionCreators } from "redux"
import { connect } from "react-redux"
import ImmutablePropTypes from "react-immutable-proptypes"

import AttachmentList from "./AttachmentList"
import { getComment } from "../selectors"
import * as commentActions from "../actions/commentActions"

class CommentItem extends Component {
  static propTypes = {
    comment: ImmutablePropTypes.record.isRequired,
    taskId:  PropTypes.string.isRequired,
    actions: PropTypes.objectOf(PropTypes.func.isRequired).isRequired,
  }

  onDelete(comment) {
    this.props.actions.removeComment(comment, this.props.taskId)
  }

  render() {
    const { comment } = this.props
    const { text, attachments } = comment

    return (
      <div className="comment">
        <a className="comment-delete" onClick={_ => this.onDelete(comment)}>
          <span className="fas fa-times-circle"></span>
        </a>
        {text}
        { !attachments.isEmpty() &&
          <AttachmentList commentId={comment.id} />
        }
      </div>
    )
  }
}

export default connect(
  (state, ownprops) => ({
    taskid:  ownprops.taskid,
    comment: getComment(state, ownprops),
  }),
  dispatch => ({ actions: bindActionCreators(commentActions, dispatch) }),
)(CommentItem);

