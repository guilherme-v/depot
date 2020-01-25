import React from 'react'

import NoPayType from './NoPayType';
import CreditCardPayType from './CreditCardPayType';
import CheckPayType from './CheckPayType';
import PurchaseOrderPayType from './PurchaseOrderPayType';

class PayTypeSelector extends React.Component {
    constructor(props) {
        super(props);
        this.onPayTypeSelected = this.onPayTypeSelected.bind(this);
        this.state = {selectedPayType: null};
    }

    render() {
        let PayTypeCustomComponent = NoPayType;
        let curPT = this.state.selectedPayType;
        if (curPT === "Credit card") {
            PayTypeCustomComponent = CreditCardPayType;
        } else if (curPT === "Check") {
            PayTypeCustomComponent = CheckPayType;
        } else if (curPT === "Purchase order") {
            PayTypeCustomComponent = PurchaseOrderPayType;
        }

        return (
            <div>
                <div className="field">
                    <label htmlFor="order_pay_type">Pay type</label>
                    <select name="order[pay_type]" id="order_pay_type" onChange={this.onPayTypeSelected}>
                        <option value="">Select a payment method</option>
                        <option value="Check">Check</option>
                        <option value="Credit card">Credit card</option>
                        <option value="Purchase order">Purchase order</option>
                    </select>
                </div>
                <PayTypeCustomComponent/>
            </div>
        );
    }

    onPayTypeSelected(event) {
        console.log(event.target.value);
        this.setState({selectedPayType: event.target.value});
    }
}

export default PayTypeSelector