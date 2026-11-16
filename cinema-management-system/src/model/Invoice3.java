package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

/**
 * Lớp thực thể Hóa đơn thanh toán (Invoice3)
 * Lưu trữ thông tin giao dịch mua vé của khách hàng và danh sách các vé được thanh toán.
 */
public class Invoice3 implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Date createdDate;
    private float totalAmount;
    private String paymentMethod;
    private Customer3 customer;
    private Saler3 saler;
    private ArrayList<Ticket3> tickets;

    public Invoice3() {
        this.tickets = new ArrayList<>();
    }

    public Invoice3(int id, Date createdDate, float totalAmount, String paymentMethod) {
        this.id = id;
        this.createdDate = createdDate;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.tickets = new ArrayList<>();
    }

    public Invoice3(int id, Date createdDate, float totalAmount, String paymentMethod, Customer3 customer, Saler3 saler, ArrayList<Ticket3> tickets) {
        this.id = id;
        this.createdDate = createdDate;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.customer = customer;
        this.saler = saler;
        this.tickets = (tickets != null) ? tickets : new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Customer3 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer3 customer) {
        this.customer = customer;
    }

    public Saler3 getSaler() {
        return saler;
    }

    public void setSaler(Saler3 saler) {
        this.saler = saler;
    }

    public ArrayList<Ticket3> getTickets() {
        return tickets;
    }

    public void setTickets(ArrayList<Ticket3> tickets) {
        this.tickets = tickets;
    }

    public Ticket3[] getTicketsArray() {
        if (tickets == null) return new Ticket3[0];
        return tickets.toArray(new Ticket3[0]);
    }

    public void setTicketsArray(Ticket3[] ticketsArray) {
        this.tickets = new ArrayList<>();
        if (ticketsArray != null) {
            for (Ticket3 t : ticketsArray) {
                this.tickets.add(t);
            }
        }
    }

    public int getTotalTickets() {
        return tickets != null ? tickets.size() : 0;
    }

    @Override
    public String toString() {
        return "Invoice3 [id=" + id + ", createdDate=" + createdDate + ", totalAmount=" + totalAmount
                + ", paymentMethod=" + paymentMethod + ", totalTickets=" + getTotalTickets() + "]";
    }
}
